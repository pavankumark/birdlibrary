class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added_on, type: DateTime, :default => Time.now
  field :visible, type: Boolean, :default => false

  validate :unique_continent
  validate :valid_continent

  ValidContinents = %w(Asia Africa North\ America South\ America Antarctica Europe Australia)
  def unique_continent
    if continents && Array === continents
      unless continents.uniq == continents
        errors.add(:continents, "contains duplicate records")
      end
    else
      errors.add(:continents, "continents is required")
    end
  end

  def valid_continent
    if continents && Array === continents
      continents.each do |continent|
        errors.add(:continents, "#{continent} is not a string") unless String === continent
        errors.add(:continents, "#{continent} is not valid continent") unless ValidContinents.include?(continent.capitalize)
      end
    end
  end

end
