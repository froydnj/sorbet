# typed: true
# frozen_string_literal: true

require_relative './constant__class_definition.rb'

sig { params(foo: Foo::Foo).returns(Foo::Foo) }
def foo(foo); end
