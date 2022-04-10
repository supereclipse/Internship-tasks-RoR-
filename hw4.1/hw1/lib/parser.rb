# frozen_string_literal: true

require 'csv'

# class Parser
class Parser
  def initialize
    @dir = ''
    @keys = %i[]
  end

  # Возвращает массив хешей
  def pull_hash
    convert_to_hash
  end

  # Возвращает массив строк
  def pull_arr
    read
  end

  def read
    CSV.read(@dir)
  end

  def convert_to_hash
    read.collect { |a| Hash[[@keys, a].transpose] }
  end
end
