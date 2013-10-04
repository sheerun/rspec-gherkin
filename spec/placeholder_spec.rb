require 'rspec-gherkin/placeholder'

describe RspecGherkin::Placeholder do
  def anchor(exp)
    Regexp.new("^#{exp}$")
  end

  describe ".resolve" do
    it "returns a regexp for the given placeholder" do
      placeholder = RspecGherkin::Placeholder.add(:test) { match(/foo/); match(/\d/) }
      resolved = RspecGherkin::Placeholder.resolve(:test)
      "foo".should =~ anchor(resolved)
      "5".should =~ anchor(resolved)
      "bar".should_not =~ anchor(resolved)
    end

    it "fall through to using the standard placeholder regexp" do
      resolved = RspecGherkin::Placeholder.resolve(:does_not_exist)
      "foo".should =~ anchor(resolved)
      '"this is a test"'.should =~ anchor(resolved)
      "foo bar".should_not =~ anchor(resolved)
    end
  end

  describe ".apply" do
    it "returns a regexp for the given placeholder" do
      placeholder = RspecGherkin::Placeholder.add(:test) do
        match(/foo/) { :foo_bar }
        match(/\d/) { |num| num.to_i }
      end
      RspecGherkin::Placeholder.apply(:test, "foo").should eq(:foo_bar)
      RspecGherkin::Placeholder.apply(:test, "5").should eq(5)
      RspecGherkin::Placeholder.apply(:test, "bar").should eq("bar")
    end

    it "extracts any captured expressions and passes them to the block" do
      placeholder = RspecGherkin::Placeholder.add(:test) do
        match(/mo(nk)(ey)/) { |nk, ey| nk.to_s.reverse + '|' + ey.to_s.upcase }
      end
      RspecGherkin::Placeholder.apply(:test, "monkey").should eq('kn|EY')
      RspecGherkin::Placeholder.apply(:test, "bar").should eq("bar")
    end
  end

  describe "#regexp" do
    it "should match a given fragment" do
      placeholder = RspecGherkin::Placeholder.new(:test) { match(/foo/) }
      "foo".should =~ placeholder.regexp
    end

    it "should match multiple fragments" do
      placeholder = RspecGherkin::Placeholder.new(:test) { match(/foo/); match(/\d/) }
      "foo".should =~ placeholder.regexp
      "5".should =~ placeholder.regexp
    end

    it "should not match an incorrect fragment" do
      placeholder = RspecGherkin::Placeholder.new(:test) { match(/foo/) }
      "bar".should_not =~ placeholder.regexp
    end

    it "should not multiple incorrect fragments" do
      placeholder = RspecGherkin::Placeholder.new(:test) { match(/foo/); match(/\d/) }
      "bar".should_not =~ placeholder.regexp
    end
  end
end
