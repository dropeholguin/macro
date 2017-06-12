ActiveAdmin.register Privacy do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :body, :type, :version

form do |f|
    f.inputs 'Details' do
      f.input :type
      f.input :version
      f.input :body
    end
    f.actions
  end
end
