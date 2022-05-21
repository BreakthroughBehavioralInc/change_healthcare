RSpec.describe ChangeHealthcare, :vcr do
  it "has a version number" do
    expect(ChangeHealthcare::VERSION).not_to be nil
  end
end
