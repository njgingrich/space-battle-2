def define_component(opts={})
  attrs = opts[:attrs]
  Class.new do
    if attrs
      attr_accessor *attrs
    end

    def initialize(initial_values={})
      initial_values.each do |k,v|
        instance_variable_set("@#{k}",v)
      end
    end
  end
end

class TileInfo
  attr_accessor :dirty_tiles, :interesting_tiles#, :tiles 
  def initialize
    @dirty_tiles = Set.new
    @interesting_tiles = Set.new
    # @tiles = Hash.new do |h, k| 
    #   h[k] = {}
    # end
  end
end

class MapInfo
  attr_accessor :tiles, :width, :height
  def initialize(width, height)
    @width = width
    @height = height
    @tiles = {}
    # @tiles = Hash.new do |h, k| 
    #   h[k] = {}
    # end
  end
end

class MovementCommand
  attr_accessor :target_vec
  def initialize(target_vec:)
    @target_vec = target_vec
  end
end

class Unit
  attr_accessor :status, :dirty, :type
  def initialize(status: :idle, type: :worker)
    @status = status
    @dirty = true
    @type = type
    @alive = true
  end
  def dirty?
    @dirty
  end
end
class ResourceCarrier
  attr_accessor :resource
  def initialize
    @resource = 0
  end
end
Base = define_component(attrs: [:resource])
Sprited = define_component(attrs: [:image])
PlayerOwned = define_component(attrs: [:id])
Health = define_component(attrs: [:points, :max])
EntityTarget = define_component(attrs: [:id])
Resource = define_component(attrs: [:value, :total])
Timed = define_component(attrs: [:accumulated_time_in_ms])
Ranged = define_component(attrs: [:distance])
Speed = define_component(attrs: [:speed])
Attack = define_component(attrs: [:damage,:range])
AttackCommand = define_component(attrs: [:id,:dx,:dy])
Shooter = define_component(attrs: [:reload_time, :current_reload])

class Position
  attr_accessor :x, :y, :z
  def initialize(x:,y:,z:2)
    @x = x
    @y = y
    @z = z
  end

  def to_vec
    vec(@x, @y)
  end
end
class TilePosition < Position; end

class Velocity < Vec
end

class Label
  attr_accessor :text, :size, :font
  def initialize(size:,text:"",font:nil)
    @size = size
    @font = font
    @text = text
  end
end

class LevelTimer; end
class Timer
  attr_accessor :ttl, :repeat, :total, :event, :name, :expires_at, :keep
  def initialize(name, ttl, repeat=false, event = nil)
    @name = name
    @total = ttl
    @ttl = ttl
    @repeat = repeat
    @event = event
  end
end

class SoundEffectEvent
  attr_accessor :sound_to_play
  def initialize(sound_to_play)
    @sound_to_play = sound_to_play
  end
end
