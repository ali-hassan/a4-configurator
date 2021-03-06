ActiveAdmin.register GenderOption do
  menu parent: "Uniform Builder"
  permit_params :gender_id, :name
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :gender_id, as: :select, collection: Gender.all.collect{|gender| [gender.gender, gender.id]}
    end
    f.actions
  end

end