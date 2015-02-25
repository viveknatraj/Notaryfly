if ['2.3.8', '2.3.9', '2.3.10', '2.3.11','2.3.14','2.3.15'].include?(Rails.version) && Gem.available?('mongrel', '~>1.1.5') && self.class.const_defined?(:Mongrel)

end