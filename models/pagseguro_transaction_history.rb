require 'open-uri'
require 'date'
require 'cgi'
require 'nokogiri'
require './models/pagseguro_transaction'

module Pagseguro
  class TransactionHistory
    API_ENTRY_POINT = "https://ws.pagseguro.uol.com.br/v2/transactions"
    DATE_FORMAT = "%Y-%m-%dT%H:%M"

    attr_reader :raw, :transactions
    attr_reader :email, :token

    def initialize(opts)
      @raw = XML.new query(opts)
      @email = opts.fetch(:email)
      @token = opts.fetch(:token)
      @transactions = transactions_collection
    end

    def self.last_30_days(opts)
      new(
        :initialDate => Date.today.prev_month.to_time,
        :finalDate => Date.today.to_time,
        :maxPageResults => 1000,
        :page => 1,
        :email => opts[:email],
        :token => opts[:token]
      )
    end

    %w{pending paid cancelled}.each do |status_name|
      define_method(:"#{status_name}_transactions") do
        transactions.select(&:"#{status_name}?")
      end
    end
 
    private

    class XML
      attr_reader :doc

      def initialize(raw_xml)
        @doc = Nokogiri::XML(raw_xml)
      end

      def transactions
        doc.xpath '//transactions/transaction'
      end
    end

    def transactions_collection
      @raw.transactions.map {|node| 
        Transaction.from_history_xml(self, node)
      }
    end

    def query(params)
      open("#{API_ENTRY_POINT}?#{query_string(params)}").read
    end

    def query_string(params)
      str = params.map do |k, v|
        if k.to_s.end_with? 'Date'
          v = v.strftime(DATE_FORMAT)
        end
        "#{k}=#{CGI.escape v.to_s}"
      end
      str.join('&')
    end
  end
end
