extends NPC


export var quest_id: String
export(String, "TimelineDropdown") var quest_before: String
export(String, "TimelineDropdown") var quest_ongoing: String
export(String, "TimelineDropdown") var quest_after: String


func interact() -> void:
	match Data.quests[quest_id].status:
		"before":
			Dialogue.start(quest_before)
		"ongoing":
			Dialogue.start(quest_ongoing)
		"after":
			Dialogue.start(quest_after)
