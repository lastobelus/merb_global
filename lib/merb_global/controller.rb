require 'merb_global/base'

module Merb
  class Controller
    include Merb::Global

    class_inheritable_accessor :_mg_locale

    before :setup_language

    # Sets the language of block.
    #
    # The block should return language or nil if other method should be used
    # to determine the language
    #
    # Please note that this method is deprecated and the preferred method is
    # locale.
    def self.language(&block)
      self._mg_locale = block
    end
    # Sets the language of block.
    #
    # The block should return language or nil if other method should be used
    # to determine the language
    def self.locale(&block)
      self._mg_locale = block
    end

    def setup_language
      # Set up the language
      accept_language = self.request.env['HTTP_ACCEPT_LANGUAGE']
      
      # allow storing locale in session
      if Merb::Global.config(:locale_in_session, false)
        if params[:locale]
          session[:locale] = params[:locale]
        elsif session[:locale]
          params[:locale] = session[:locale]
        end
      end

      # handle _ as locale separator
      params[:locale].gsub!('_','-') unless params[:locale].blank?

      Merb::Global::Locale.current =
        (!params[:locale].nil? && params[:locale].to_s.length > 0 && Merb::Global::Locale.new(h(params[:locale]))) ||
        (self._mg_locale &&
         Merb::Global::Locale.new(self.instance_eval(&self._mg_locale))) ||
         Merb::Global::Locale.from_accept_language(accept_language) || 
         Merb::Global::Locale.new('en')
      
      # store the chosen locale back in the params in case it was not there
      params[:locale] ||= Merb::Global::Locale.current.to_s
      
    end
    
  end
end
