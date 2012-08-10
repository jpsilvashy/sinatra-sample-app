class Sinatra::Base
  helpers do

    # HTML escape text
    def h(text); ERB::Util.html_escape(text); end

    # URL encode text
    def u(text); ERB::Util.url_encode(text); end

    # Get a local path without browser redirect
    def get_alias(url)
      call env.merge('PATH_INFO' => url)
    end

  end
end