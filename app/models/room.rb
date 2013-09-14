class Room < ActiveRecord::Base
  belongs_to :property
  
  validates :property_id, presence: true
  
  serialize :features
  
  before_create :add_features
  
  scope :bedrooms, -> { where(room_type: "bedroom") }
  scope :bathrooms, -> { where(room_type: "bathrooms") }
  
  def self.type_count(type)
    where(room_type: type).count
  end
  
  def add_features
    if room_type == "bedroom"
      self.features = base_features + bedroom_features
    elsif room_type == "bathroom"
      self.features = base_features + bathroom_features
    elsif room_type == "kitchen"
      self.features = base_features + kitchen_features
    else
      self.features = base_features
    end
  end
  
  def base_features
    ['walls', 'baseboards', 'doors', 'floors', 'ceiling', 'light fixtures']
  end
  
  def bedroom_features
    ['windows', 'screens', 'blinds/drapes', 'closets/shelves']
  end
  
  def bathroom_features
    ['tub/shower', 'toilet', 'countertop', 'sink', 'cabinets/shelves', 'mirrors', 'fan']
  end
  
  def kitchen_features
    ['fridge', 'range/oven', 'dishwasher', 'disposal', 'countertop', 'sink', 'cabinets/shelves']
  end
  
  def window_features
    ['windows', 'screens', 'blinds/drapes']
  end
  
  # old methods for creating feartures hash
  # def add_features
  #   self.features = base_features
  #   if room_type == "bedroom"
  #     self.features.merge!(bedroom_features).merge!(window_features)
  #   elsif room_type == "bathroom"
  #     self.features.merge!(bathroom_features)
  #   elsif room_type == "kitchen"
  #     self.features.merge!(kitchen_features)
  #   end
  # end
  # 
  # def base_features
  #   { "base" => ['walls', 'baseboards', 'doors', 'floors', 'ceiling', 'light fixtures'] }
  # end
  # 
  # def bedroom_features
  #   { "bedroom" => ['windows', 'screens', 'blinds/drapes', 'closets/shelves'] }
  # end
  # 
  # def bathroom_features
  #   { "bathroom" => ['tub/shower', 'toilet', 'countertop', 'sink', 'cabinets/shelves', 'mirrors', 'fan'] }
  # end
  # 
  # def kitchen_features
  #   { "kitchen" => ['fridge', 'range/oven', 'dishwasher', 'disposal', 'countertop', 'sink', 'cabinets/shelves'] }
  # end
  # 
  # def window_features
  #   { "windows" => ['windows', 'screens', 'blinds/drapes'] }
  # end
    
end
