#!/usr/bin/env ruby
require './color'

def diff(path1, path2) 
  f1 = File.join(path1, 'AMIconfont.h')
  f2 = File.join(path2, 'AMIconfont.h')
  s1 = File.open(f1).read
  s2 = File.open(f2).read
  s1.gsub!(/\r\n?/, "\n")
  s2.gsub!(/\r\n?/, "\n")
  a1 = []
  a2 = []
  dels = []
  adds = []

  head = 'UIKIT_EXTERN NSString *const '
  head_len = head.length

  s1.each_line do |line|
    if line.start_with?(head)
      line = line[head_len..-3]
      a1.push line
    end
  end

  s2.each_line do |line|
    if line.start_with?(head)
      line = line[head_len..-3]
      a2.push line
    end
  end

  a1.each { |name|
    if !a2.include?(name)
      dels.push name
    end
  }

  a2.each { |name|
    if !a1.include?(name)
      adds.push name
    end
  }

  if !dels.empty? or !adds.empty? then
    puts "Changes:".yellow
    puts ''

    dels.each { |name|
      puts "  - #{name}".red
    }
    adds.each { |name|
      puts "  + #{name}".green
    }

    puts ''
    return true
  end
  
  return false
end