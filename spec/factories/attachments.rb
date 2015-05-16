FactoryGirl.define do
  factory :attachment do
    space
    file_name     { File.open('./app/assets/images/no_image.png') }
    # content_type  { file_name.content_type }
    file_size     { file_name.size }
  end
end
