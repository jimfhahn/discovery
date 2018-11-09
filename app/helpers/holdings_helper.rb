require_relative '../services/sfx_service.rb'
require_relative '../services/symphony_service.rb'
require_relative '../services/marc_module.rb'

module HoldingsHelper
  include MarcModule

  def holdings(document, method)
    doc = nokogiri document
    id = get_marc_id(doc)
    begin
      SymphonyService.new(id).send(method)
    rescue SymphonyService::Error::HTTPError => e
      logger.error e.message
      nil
    end
  end

  def fetch_sfx_holdings(document)
    SFXService.new(document).targets
  rescue SFXService::Error::HTTPError => e
    logger.error e.message
    nil
  end

  # TODO: If the way that libraries are mapped changes (replacing config/location.yml) this should follow that scheme
  UAL_SHIELD_LIBRARIES = [
    SYMPHONY_LIBRARY_LOCATIONS[:uainternet],
    SYMPHONY_LIBRARY_LOCATIONS[:neosfree]
  ].freeze

  # determines whether or not ual shield should be displayed for the item
  def display_ual_shield(document)
    return false unless document['location_tesim']
    UAL_SHIELD_LIBRARIES.each { |library| return true if document['location_tesim'].include? library }
    false
  end

  # TODO: If the way that libraries are identified changes (replacing config/location.yml) this should follow that scheme
  READ_ON_SITE_LOCATION_RCRF = 'UARCRF'.freeze # Research and Collections Resource Facility
  READ_ON_SITE_LOCATION_BPSC = 'UASPCOLL'.freeze # Bruce Peel Special Collections

  # returns path to read on site form
  # TODO: Should be passing in title as well, need to work out business logic for this though
  def read_on_site_path(item, document_id)
    if item[:location] == READ_ON_SITE_LOCATION_RCRF
      new_rcrf_read_on_site_request_path(item_url: catalog_url(document_id))
    elsif item[:location] == READ_ON_SITE_LOCATION_BPSC
      new_bpsc_read_on_site_request_path(item_url: catalog_url(document_id))
    end
  end

  # returns the library description that matches the code coming from symphony ws
  # TODO: If the way that libraries are mapped changes (replacing config/location.yml) this should follow that scheme
  def library_location(library_code)
    SYMPHONY_LIBRARY_LOCATIONS[library_code.downcase.delete('_').to_sym]
  end
end
