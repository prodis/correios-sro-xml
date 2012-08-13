# encoding: UTF-8

def mock_request_for(response)
  url = Regexp.new("http://websro.correios.com.br/sro_bin/sroii_xml.eventos")
  WebMock::API.stub_request(:post, url).to_return(:status => 200, :body => body_for(response))
end

def body_for(response)
  case response
  when :success_response_one_object,
       :success_response_many_objects,
       :success_response_many_objects_international,
       :failure_response_not_found
    read_file_for(response)
  else
    response
  end
end

def read_file_for(filename)
  File.open("#{File.dirname(__FILE__)}/responses/#{filename}.xml").read
end
