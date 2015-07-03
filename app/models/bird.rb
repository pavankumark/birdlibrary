class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: DateTime, :default => Time.now
  field :visible, type: Boolean, :default => false

  validates :name, presence: true
  validates :family, presence: true
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

  class << self

    def make(params)
      bird = Bird.new()
      params.delete('bird')
      required = %w(name family continents)
      missing = required.reject {|k| params.keys.include?(k)}
      if missing.count == 0
        bird.name = params['name'].strip
        bird.family = params['family'].strip
        bird.continents = params['continents'].to_a
        bird.visible = params['visible'] if params['visible']
        bird.added = params['added'].strip if params['added']
        bird
      else
        nil
      end
    end

  end

end
