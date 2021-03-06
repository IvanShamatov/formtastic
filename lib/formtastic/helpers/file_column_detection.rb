module Formtastic
  module Helpers
    # @private
    module FileColumnDetection

      def is_file?(method, options = {})
        @files ||= {}
        @files[method] ||= (options[:as].present? && options[:as] == :file) || begin
          file = @object.send(method) if @object && @object.respond_to?(method)
          case 
          when file_methods.any?{|m| file.respond_to?(m)} 
            true
          when file.is_a?(Array) && file_methods.any?{|m| file.first.respond_to?(m)}
            options[:input_html] ||= {}
            options[:input_html].merge(multiple: true)
            true
          else 
            false
          end
        end
      end

    end
  end
end