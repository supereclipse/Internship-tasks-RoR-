# frozen_string_literal: true

require 'csv'

# class Parser
class Parser
  def initialize(dir, keys)
    @dir = dir
    @keys = keys
  end

  # Возвращает массив хешей
  def pull_hash
    read.collect { |a| Hash[[@keys, a].transpose] }
  end

  def read
    CSV.read(@dir)
  end
end
