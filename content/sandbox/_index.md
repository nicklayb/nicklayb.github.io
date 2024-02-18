+++
title = "Sandbox"
description = "Various open projects and experimentation I brought up with."
template = "sandbox.html"

[[extra.sandbox]]
title = "Chord Sheet"
tags = ["elm", "chord", "music" ,"sheet"]
description = """
Chord sheet
"""
image = "chord_sheet.png"

[[extra.sandbox.links]]
name = "Demo"
link = "https://nicklayb.github.io/chord_sheet"

[[extra.sandbox.links]]
name = "Source"
link = "https://github.com/nicklayb/chord_sheet"

[[extra.sandbox]]
title = "Unox"
tags = ["elixir", "phoenix", "liveview", "process", "uno"]
description = """
Unox is a an implementation of the popular friendship-breaking game called UNO. The purpose of this project is to make my entry to the PhoenixPhrenzy challenge where we had to build application using Phoenix LiveView. The game is persistanceless, there is no database or file attached as persistency, everything is in the ram. Erlang makes it so easy to create processes that it became just an obvious choice. The only Javascript in the app is Phoenix's/LiveView Socket connection and the Desktop notification service. 
"""
image = "unox.gif"

[[extra.sandbox.links]]
name = "Source"
link = "https://github.com/nicklayb/unox"

[[extra.sandbox]]
title = "K U B"
tags = ["elm", "game"]
description = """
K U B is a block collapsing game. The goal is to delete all the blocks by removing regions of two blocks or more. You have basics stats about the remaining blocks by colors and also a percent of the cleared block. Before starting the game, a seet value needs to be input (default to 0). Re-using the same seed will generate the same game. Note: The design is not completely mobile-proof, playing it on a computer might give a better experience.
"""
image = "kub.png"

[[extra.sandbox.links]]
name = "Demo"
link = "https://nicklayb.github.io/kub"

[[extra.sandbox.links]]
name = "Source"
link = "https://github.com/nicklayb/kub"

[[extra.sandbox]]
title = "Labyrelm"
tags = ["elm", "game", "labyrinth", "prim"]
description = """
Labyrelm is a labyrinth resolving game. The goal is to find the exit of the maze by browsing the paths. The exit is always at the bottom of the maze. It uses the Prim algorithm to generate the maze, which is a greedy algorithm. So generating a maze bigger that 30x30 might take a while. On the opening you will be asked for a size and a seed. Using the same seed twice will generate the exact same game. 
"""
image = "labyrelm.png"

[[extra.sandbox.links]]
name = "Demo"
link = "https://nicklayb.github.io/labyrelm"

[[extra.sandbox.links]]
name = "Source"
link = "https://github.com/nicklayb/labyrelm"

[[extra.sandbox]]
title = "Gelm of life"
tags = ["elm", "game-of-life", "cellular-automaton"]
description = """
Gelm of life is and Elm implementation of popular Conway's Game of Life. This is not really a "game" it is a cellular automaton. I always loved implementing this "game" in every language I learn to get more familiar with the language. On the opening you will be asked for a size and a seed. Using the same seed twice will generate the exact same game. 
"""
image = "gol.png"

[[extra.sandbox.links]]
name = "Demo"
link = "https://nicklayb.github.io/game-of-life"

[[extra.sandbox.links]]
name = "Source"
link = "https://github.com/nicklayb/game-of-life"
+++
