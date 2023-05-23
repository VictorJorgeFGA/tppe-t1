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

  def self.multiple_values_using_xor_test_cases
    [
      {'parameters' => {'matricula' => '',          'cpf' => ''}, 'answer' => false},
      {'parameters' => {'matricula' => '18000000',  'cpf' => ''}, 'answer' => true},

      {'parameters' => {'matricula' => '',          'cpf' => '1000000'},                        'answer' => true},
      {'parameters' => {'matricula' => '180000000', 'cpf' => '1000000'},                        'answer' => false},
      {'parameters' => {'matricula' => '180000000', 'cpf' => '1000000', 'email' => ''},         'answer' => false},
      {'parameters' => {'matricula' => '180000000', 'cpf' => '',        'email' => ''},         'answer' => true},
      {'parameters' => {'matricula' => '180000000', 'cpf' => '1000000', 'email' => 'AAAAAAAA'}, 'answer' => true},
    ]
  end

  def self.multiple_atomic_and_composed_attributes_or_test_cases
    [
      {'parameters' => {'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => ''}, 'matricula' => '', 'cpf' => ''}, 'answer' => false},
      {'parameters' => {'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => ''}, 'matricula' => '180000000', 'cpf' => '1000000'}, 'answer' => true},
      {'parameters' => {'nome_completo' => {'primeiro_nome' => 'takashi', 'segundo_nome' => ''}, 'matricula' => '', 'cpf' => ''}, 'answer' => true},
      {'parameters' => {'nome_completo' => {'primeiro_nome' => 'takashi', 'segundo_nome' => 'aoki'}, 'matricula' => '', 'cpf' => ''}, 'answer' => true}
    ]
  end

  def self.multiple_atomic_and_composed_attributes_xor_test_cases
    [
      {'parameters' => {'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => ''}, 'matricula' => '', 'cpf' => ''}, 'answer' => false},
      {'parameters' => {'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => ''}, 'matricula' => '180000000', 'cpf' => '1000000'}, 'answer' => false},
      {'parameters' => {'nome_completo' => {'primeiro_nome' => 'takashi', 'segundo_nome' => ''}, 'matricula' => '', 'cpf' => ''}, 'answer' => true},
      {'parameters' => {'nome_completo' => {'primeiro_nome' => 'takashi', 'segundo_nome' => 'aoki'}, 'matricula' => '', 'cpf' => ''}, 'answer' => false},
      {'parameters' => {'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => ''}, 'matricula' => '100000000', 'cpf' => ''}, 'answer' => true}
    ]
  end

  def self.multiple_atomic_and_composed_attributes_with_arrays_or_test_cases
    [
      {'parameters' =>
        {
          'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => ''},
          'telefones' => [{'cod' => '1', 'numero' => ''}, {'cod' => '', 'numero' => ''}],
          'matricula' => '',
          'cpf' => ''},
        'answer' => true
      },
      {'parameters' =>
        {
          'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => ''},
          'telefones' => [{'cod' => '', 'numero' => '12345'}, {'cod' => '', 'numero' => ''}],
          'matricula' => '',
          'cpf' => ''},
        'answer' => true
      },
      {'parameters' =>
        {
          'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => ''},
          'telefones' => [{'cod' => '', 'numero' => ''}, {'cod' => '12334', 'numero' => ''}],
          'matricula' => '',
          'cpf' => ''},
        'answer' => true
      },
      {'parameters' =>
        {
          'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => '123456'},
          'telefones' => [{'cod' => '', 'numero' => ''}, {'cod' => '', 'numero' => ''}],
          'matricula' => '',
          'cpf' => ''},
        'answer' => true
      },
      {'parameters' =>
        {
          'nome_completo' => {'primeiro_nome' => '', 'segundo_nome' => '123456'},
          'telefones' => [{'cod' => '', 'numero' => '12345'}, {'cod' => '', 'numero' => ''}],
          'matricula' => '',
          'cpf' => 'aaaa'},
        'answer' => true
      },
    ]
  end

  atomic_test_cases.each_with_index do |test_case, idx|
    define_method "test_atomic_completude_#{idx}" do
      assert_equal test_case['answer'], Completude::get_completude(test_case['parameters'])
    end
  end

  multiple_values_using_or_test_cases.each_with_index do |test_case, idx|
    define_method "test_multiple_atomic_values_using_or_#{idx}" do
      assert_equal test_case['answer'], Completude::get_completude(test_case['parameters'])
    end
  end

  multiple_values_using_xor_test_cases.each_with_index do |test_case, idx|
    define_method "test_multiple_atomic_values_using_xor_#{idx}" do
      assert_equal test_case['answer'], Completude::get_completude(test_case['parameters'], :xor)
    end
  end

  multiple_atomic_and_composed_attributes_or_test_cases.each_with_index do |test_case, idx|
    define_method "test_multiple_atomic_and_composed_attributes_or_test_cases_#{idx}" do
      assert_equal test_case['answer'], Completude::get_completude(test_case['parameters'], :or)
    end
  end

  multiple_atomic_and_composed_attributes_xor_test_cases.each_with_index do |test_case, idx|
    define_method "test_multiple_atomic_and_composed_attributes_xor_test_cases_#{idx}" do
      assert_equal test_case['answer'], Completude::get_completude(test_case['parameters'], :xor)
    end
  end

  multiple_atomic_and_composed_attributes_with_arrays_or_test_cases.each_with_index do |test_case, idx|
    define_method "test_multiple_atomic_and_composed_attributes_with_arrays_or_test_cases_#{idx}" do
      assert_equal test_case['answer'], Completude::get_completude(test_case['parameters'], :or)
    end
  end
end