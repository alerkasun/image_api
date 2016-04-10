FactoryGirl.define do
  factory :resized_image do
    orig_name "test.JPG"
    id '1'
    file_name "1.JPG"
    path Rails.root.join( 'spec', 'fixtures', 'email@gmail.com', '1' )
    url ['localhost:3000','uploads','email@gmail.com','1','1.JPG'].join('/')
  end
end
