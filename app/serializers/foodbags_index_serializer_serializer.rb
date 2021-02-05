class FoodbagsIndexSerializerSerializer < ActiveModel::Serializer
  attributes :id, :pickuptime, :status
  attribute :created_at do
    object.created_at.to_formatted_s(:db)
  end
  belongs_to :donor, serializer: UserUpdateSerializer
end
