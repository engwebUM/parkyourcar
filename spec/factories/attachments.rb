FactoryGirl.define do
  factory :attachment do
    space
    file_name     { File.open('./app/assets/images/no_image.png') }
  end
end
