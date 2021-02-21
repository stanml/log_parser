# Parsing Logs

## Contents 
1. Running the code
2. General Approach
3. Classes and their relationship
4. Putting it together
5. If I had more time


### Running the code
To run the log parser, navigate to the top level `log_parser` directory which includes the `/lib` folder that contains the classes and script. I chose not to upload the `webserver.log` file to GitHub so you'll need to obtain an example log file and use the correct path as the input to the script. From the top level directory run the command: `
ruby lib/log_parser.rb webserver.log`

To run the tests, ensure you have the Rspec gem installed and from the top level directory run the command: `rspec spec`. You'll need to be in the correct directory as the tests make use of `require_relative` to load the individual classes.

###  General Approach
The first thing that struck me with this problem was the unbounded input of the `webserver.log` file. I could write a quick solution that assumed the file would always be 500 lines long, however in reality, log files have the potential to be **much larger** than the 12KB file provided. 

To account for this, I chose to use Ruby's `IO` library, specifically for the method `IO.foreach` as this reads the file line by line rather than loading it all into memory, which would have significant performance implications should the file grow to a substantial size.

I also chose to be selective about which classes should be stateful as parsing a large file into multiple Ruby structures could also have performance implications. For this reason the classes have a very specific purpose and some have a minimal state.

I chose to use regular expressions instead of something like `String.split` so that the script had more control over unstructured strings and potential changes in the data coming in. It's not perfect but I think it's more robust than using the split method and then subsequent arrays.  

Finally, I wanted to write reuse-able code that could be extended for use cases outside of this example, code that could be tested easily, and keep hard-coded variables outside the classes.


###  Classes and their relationship

There are 3 classes that handle the jobs needed to get to the required outcome
1. **RegexParser** is designed to parse a single log line, based on two instance variables. First is a specified `key` regex pattern that is used to extract a specific sub-string from the text. Second is a `values` array of regex patterns that extract subsequent patterns that can be associated with the `key`. The two instance variable are set outside the class, therefore enabling reuse-able and configurable functionality.
2. **FileParser** reads the lines from within the log file. This class expects a RegexParser class to be specified to evaluate each line. This means that different regex patterns could be used when the file is read for use cases outside of this one. It reads the lines and builds a hash around the keys outputted by the RegexParser.
3. **AggregateViews** purposefully has no state to ensure that if the input file became larger there aren't multiple large hashes in the process that would eat up memory. Given that the hash the FileParser returns is aggregated, there is some protection here, but if the log file scaled up to millions of rows, then this decision could need revisiting. The `aggregate()` method can also be configured to count unique values using an input boolean argument. 

###  Putting it together

Now that the specific tasks are encapsulated into individual classes the job of the script can be reduced to setting the hardcoded variables specific to this task (file path & regular expressions) and configuring classes and their interactions.

###  If I had more time
Recognising that the unbounded input of log files have the biggest performance implications on the code I have submitted, if I were to continue spending more time on this task I would consider the following: 
1. Creating a way to batch the input, processing chunks at a time, then aggregating the results of each batch to arrive at the final result
2. Spend some more time optimising the use of regex, the url is currently extracted based on the first `/` in the string, this could cause problems if the structure of the log changed. 
3. Potentially shelling out the parsing task to use GNU grep before creating ruby data structures. GNU grep avoids breaking the input into lines and instead creates a large buffer which is performs a search on and could be significantly more performant should the file size grow. 
