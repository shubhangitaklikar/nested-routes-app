class Blog < ActiveRecord::Base
	
	 validates :name,  :presence => true, :length => { :minimum => 10}
	 has_many :comments
end
