module Pagseguro
  class Transaction
    API_ENTRY_POINT = "https://ws.pagseguro.uol.com.br/v2/transactions"

    class Status
      PENDING = 1
      PAID = 3
      ACCEPTED = 4
      CANCELLED = 7

      def initialize(status)
        @status = status.to_i
      end

      def to_sym
        to_s.to_sym
      end

      def to_s
        return 'pending' if pending?
        return 'paid' if paid?
        return 'accepted' if paid?
        return 'cancelled' if cancelled?
      end

      def paid?
        [PAID, ACCEPTED].include? @status 
      end

      def accepted?
        @status == ACCEPTED
      end

      def cancelled?
        @status == CANCELLED
      end

      def pending?
        @status == PENDING
      end
    end

    class Customer
      attr_reader :name, :email
      def initialize(params)
        @name = params.fetch(:name)
        @email = params.fetch(:email)
      end
    end

    attr_reader :code, :email, :token

    def initialize(code, email, token)
      @code = code
      @email = email
      @token = token
    end

    def self.from_history_xml(transaction_history, node)
      new(
        HistoryXMLNode.new(node).code, 
        transaction_history.email, 
        transaction_history.token
      )
    end

    def status
      @status ||= Status.new(raw.status)
    end
            
    def customer
      @customer ||= Customer.new(:name => raw.sender_name, :email => raw.sender_email)
    end

    %w{pending paid cancelled}.each do |status_name|
      define_method(:"#{status_name}?") do
        status.send(:"#{status_name}?")
      end
    end

    def raw
      @raw ||= XML.new(query)
    end

    private
    def query
      url = "#{API_ENTRY_POINT}/#{code}?email=#{email}&token=#{token}"
      open(url).read
    end

    class HistoryXMLNode
      attr_reader :node

      def initialize(node)
        @node = node
      end

      def code
        node.xpath('./code').text
      end
    end

    class XML
      attr_reader :doc

      def initialize(raw_xml)
        @doc = Nokogiri::XML(raw_xml)
      end

      def status
        doc.xpath('//status').text
      end

      def sender_name
        doc.xpath('//sender/name').text
      end

      def sender_email
        doc.xpath('//sender/email').text
      end
    end
  end
end
