class Entrance < ActiveRecord::Base
  belongs_to :popularity  , counter_cache: true
end
