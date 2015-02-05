require "gherkin"

module RSpecGherkin
  class Builder
    module Tags
      def tags
        @raw.tags.map { |tag| tag.name.sub(/^@/, '') }
      end

      def tags_hash
        Hash[tags.map { |t| [t.to_sym, true] }]
      end

      def metadata_hash
        tags_hash
      end
    end

    module Name
      def name
        @raw.name
      end
    end

    class Feature
      include Tags
      include Name

      attr_reader :scenarios, :backgrounds
      attr_accessor :feature_tag

      def initialize(raw)
        @raw = raw
        @scenarios = []
        @backgrounds = []
      end

      def line
        @raw.line
      end
    end

    class Background
      def initialize(raw)
        @raw = raw
      end
    end

    class Scenario
      include Tags
      include Name

      attr_accessor :arguments

      def initialize(raw)
        @raw = raw
        @arguments = []
      end
    end

    class Step < Struct.new(:description, :extra_args, :line)
      # 1.9.2 support hack
      def split(*args)
        self.to_s.split(*args)
      end

      def to_s
        description
      end
    end

    attr_reader :features

    class << self
      def build(feature_file)
        RSpecGherkin::Builder.new.tap do |builder|
          parser = Gherkin::Parser::Parser.new(builder, true)
          parser.parse(File.read(feature_file), feature_file, 0)
        end
      end
    end

    def initialize
      @features = []
    end

    def background(background)
      @current_step_context = Background.new(background)
      @current_feature.backgrounds << @current_step_context
    end

    def feature(feature)
      @current_feature = Feature.new(feature)
      @features << @current_feature
    end

    def scenario(scenario)
      @current_step_context = Scenario.new(scenario)
      @current_feature.scenarios << @current_step_context
    end

    def scenario_outline(outline)
      @current_scenario_template = outline
    end

    def examples(examples)
      rows_to_array(examples.rows).each do |arguments|
        scenario = Scenario.new(@current_scenario_template)
        scenario.arguments = arguments.map do |argument|
          if numeric?(argument)
            integer?(argument) ? argument.to_i : argument.to_f
          elsif boolean?(argument)
            to_bool(argument)
          else
            argument
          end
        end

        @current_feature.scenarios << scenario
      end
    end

    def step(*)
    end

    def uri(*)
    end

    def eof
    end

    private

    def integer?(string)
      return true if string =~ /^\d+$/
    end

    def numeric?(string)
      return true if string =~ /^\d+$/
      true if Float(string) rescue false
    end

    def boolean?(string)
      string =~ (/(true|t|yes|y)$/i) ||
          string =~ (/(false|f|no|n)$/i)
    end

    def to_bool(string)
      return true if string =~ (/(true|t|yes|y|1)$/i)
      return false if string =~ (/(false|f|no|n|0)$/i)
    end

    #TODO Need to come up with better handling of support for JRuby
    def rows_to_array(rows)
      rows.map { |row| row.cells.map { |cell| RUBY_PLATFORM =~ /java/ ? cell : cell.value } }.drop(1)
    end

  end
end
