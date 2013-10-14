class Search
  class Request

    def initialize(postcode)
      @postcode = postcode
    end

    def results
      response["feed"]["entry"].map do |s|
        Service::Request.new(s['id'], distance(s)).result
      end
    end

    private

    def distance(result)
      result['content']['servicesummary']['distance']
    end

    def response
      fail Search::APIError unless request.env[:status] == 200
      Hash.from_xml(request.env[:body])
    end

    def request
      @request ||= Faraday.get(url)
    end

    def url
      "#{domain}#{action}#{params}"
    end

    def domain
      "http://v1.syndication.s.integration.choices.nhs.uk"
    end

    def action
      "/services/types/srv0317/postcode/#{postcode}.xml"
    end

    def params
      "?apikey=#{api_key}&range=50"
    end

    def api_key
      ENV["API_KEY"]
    end

    attr_reader :postcode
  end
end