require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TodoListRails
  class Application < Rails::Application    
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
                      model_specs: true,
                      view_specs: false,
                      helper_specs: false,
                      routing_specs: false,
                      controller_specs: false,
                      request_specs: false
    end

    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        class_name = instance.object.class.name.underscore
        method_name = instance.instance_variable_get(:@method_name)
        "<div class=\"has-error\">#{html_tag}
          <span class=\"help-block\">
            ! #{I18n.t("activerecord.attributes.#{class_name}.#{method_name}")}           
            #{instance.error_message.first}
          </span>
        </div>".html_safe
      end
    end
  end
end
