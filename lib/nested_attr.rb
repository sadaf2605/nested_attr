module NestedAttr
	require "factory_girl"


  class NestedAttributesStrategy
    # Author: Sadaf Noor (email@sadafnoor.com)
    
    # This is a FactoryGirl strategy that would return hash with 
    #  nested objects including has_many and belongs_to fields.
    #  has_many fields will return with hash like { model_attributes => [] } and
    #  belongs_to will return hash like {model=> {}}
    
    # Usage:
   
    #  You can register it at the begining of your factories file:
    #   FactoryGirl.register_strategy(:nested_attributes, NestedAttributesStrategy)
   
    #  Then you can use it anywhere you find useful:
    #   FactoryGirl.nested_attributes(:model_name)
    #   
    
    include NestedAttr

    def association(runner)
      runner.run
    end

    def result(evaluation)

      evaluation.object.tap do |instance|
      
        evaluation.notify(:after_build, instance) 
        
        return attributes(instance)
      end
    end


    
    private
    
    def attributes(instance)
    @created_model||=[]
      
      unless instance.instance_variables.include? :@attributes then return {} end  
      if @created_model.include? instance.class then return {} end

      @created_model << instance.class
      
      attrs = instance.attributes.delete_if do |k, _|
        ( %w(id type created_at updated_at).include?(k) or k.end_with?("_id") ) 
      end
      

      nested_reflections_belongs_to(instance).each do |ref|
        attrs.merge!("#{ref.name}" => attributes(instance.send(ref.name)))
      end

      nested_reflections_has_many(instance).each do |ref|
        if @@has_many_attributes.include? ref.name
          attrs.merge!("#{ref.name}_attributes" => instance.send(ref.name).each_with_index.map do |nested_obj,i|
            {i.to_s => attributes(nested_obj)}
          end [0])
        else
          attrs.merge!("#{ref.name.to_s.singularize}_ids" => instance.send(ref.name).each.map do |nested_obj|
            nested_obj.id.to_s
          end)  
        end

      end
      
      nested_reflections_has_and_belongs_to_many(instance).each do |ref|
        #puts ref.name
        #puts "+++"
        #puts @@allowd_nested_attributes[0].class
        #puts @@allowd_nested_attributes.include? ref.name
        #puts "---"

        if @@has_many_attributes.include? ref.name
          attrs.merge!("#{ref.name}_attributes" => instance.send(ref.name).each_with_index.map do |nested_obj,i|
            {i.to_s => attributes(nested_obj)}
          end [0])
        else
          attrs.merge!("#{ref.name.to_s.singularize}_ids" => instance.send(ref.name).each.map do |nested_obj|
            nested_obj.id.to_s
          end)  
        end
      end




      

      instance.delete 
      
      attrs
    end
   


    def nested_reflections_has_and_belongs_to_many(instance)
      instance.class.reflections.values.select do |ref|
        ref.macro == :has_and_belongs_to_many 
      end
    end

    def nested_reflections_has_many(instance)
      instance.class.reflections.values.select do |ref|
        ref.macro == :has_many && instance.respond_to?("#{ref.name}_attributes=")
      end
    end
    
    def nested_reflections_belongs_to(instance)  
      instance.class.reflections.values.select do |ref|
        ref.macro == :belongs_to && instance.respond_to?("#{ref.name}")
      end
    end

  end

  if not FactoryGirl.methods.include? :nested_attr_for

  	#puts "registered as 'FactoryGirl.nested_attr_for(:factory_name)'"
  	FactoryGirl.register_strategy(:nested_attr_for, NestedAttributesStrategy)

  end
  
  def self.nested_attr_for(factory,has_many=[])
    @@has_many_attributes = has_many

  	FactoryGirl.nested_attr_for(factory)
    
  end
end
