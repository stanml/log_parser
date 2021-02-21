class AggregateViews
		
	def self.aggregate(views, unique=false)
		sort_views(count_views(views, unique))
	end

	private

	def self.sort_views(aggregated_views)
		aggregated_views.sort_by{ |key, value| value }
	end

	def self.count_views(views, unique)
		views.each_with_object({}) do |(key, values), aggregated_views|
			aggregated_views[key] = unique ? values.uniq.count : values.count
		end
	end
end
