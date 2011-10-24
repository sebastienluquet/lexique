module ApplicationHelper
end
module NestedForm
  class Builder < ::ActionView::Helpers::FormBuilder
    def fields_for_with_nested_attributes(association_name, association, args, block)
      # TODO Test this better
      block ||= Proc.new { |fields| @template.render(:partial => "#{association_name.to_s.singularize}_fields", :locals => {:f => fields}) }
      @fields ||= {}
      @fields[association_name] = block
      super(association_name, association, args, block)
    end
  end
end
