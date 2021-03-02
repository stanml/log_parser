# Aggregates and sorts the values of a hash
class AggregateViews
  def self.aggregate(views, unique: false)
    sort_views(count_views(views, unique))
  end

  def self.sort_views(aggregated_views)
    aggregated_views.sort_by { |_key, value| value }.reverse!
  end

  def self.count_views(views, unique)
    views.transform_values do |values|
      unique ? values.uniq.count : values.count
    end
  end
end
