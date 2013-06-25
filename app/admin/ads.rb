ActiveAdmin.register Ad do

	 form do |f|
    f.inputs # Include the default inputs

    f.inputs "Options Variants" do # Make a panel that holds inputs
      f.input :variants, as: :check_boxes , collection: Variant.all # Use formtastic to output my collection of checkboxes
    end
    f.actions # Include the default actions
  end

  
end
