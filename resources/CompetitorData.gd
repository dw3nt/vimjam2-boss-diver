extends Resource
class_name CompetitorData

export(Texture) var image
export(String) var name
export(String) var description
export(int, 1, 5) var difficulty

export(Array, int) var walkDistances = [30, 68]
export(Array, float) var jumpHeightPrecentages = [0.5, 0.9]
export(Array, float) var poseTimeCooldowns = [0.2, 0.5]
