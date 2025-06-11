extends Control

func toggle_visibility():
    if GameStateManager.get_is_player_in_game():
        GameStateManager.is_in_game = false
        hide()
    else:
        GameStateManager.is_in_game = true
        show()