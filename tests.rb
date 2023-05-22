require 'minitest/autorun'
require 'byebug'
require 'pry'

load 'completude.rb'

class FeatureTests < Minitest::Test

  def self.atomic_test_cases
    [
      {'parameters' => {'matricula' => '18000000'}, 'answer' => true},
      {'parameters' => {'matricula' => ''}, 'answer' => false}
    ]
  end

  def self.multiple_values_using_or_test_cases
    [
      {'parameters' => {'matricula' => '1800000', 'cpf' => '1000000'}, 'answer' => true},
      {'parameters' => {'matricula' => '1800000', 'cpf' => ''}, 'answer' => true},
      {'parameters' => {'matricula' => '', 'cpf' => '1000000'}, 'answer' => true},
      {'parameters' => {'matricula' => '', 'cpf' => ''}, 'answer' => false},
      {'parameters' => {'matricula' => '', 'cpf' => '', 'email' => ''}, 'answer' => false},
      {'parameters' => {'matricula' => '', 'cpf' => '', 'email' => 'jaozin123@gmail.com'}, 'answer' => true},
    ]
  end

  atomic_test_cases.each_with_index do |test_case, idx|
    define_method "test_atomic_completude_#{idx}" do
      assert_equal test_case['answer'], Completude::get_completude(test_case['parameters'])
    end
  end

  multiple_values_using_or_test_cases.each_with_index do |test_case, idx|
    define_method "test_multiple_values_using_or_#{idx}" do
      assert_equal test_case['answer'], Completude::get_completude(test_case['parameters'])
    end
  end
end