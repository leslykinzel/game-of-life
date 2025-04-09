# Conway's Game of Life
from python import Python
from grid import Grid
import time
import random

var rainbow = List[String]("purple", "blue", "cyan", "green", "yellow", "orange", "red")

def run_display(
        owned grid:       Grid,
        window_height:    Int     = 600,
        window_width:     Int     = 600,
        background_color: String  = "black",
        cell_color:       String  = "green",
        pause:            Float64 = 0.01
    ) -> None:
    # Import from Python environment.
    pygame = Python.import_module("pygame")
    pygame.init()

    window = pygame.display.set_mode((window_height, window_width))
    pygame.display.set_caption("Conway's Game of Life")

    cell_height = window_height / grid.rows
    cell_width = window_width / grid.cols
    border_size = 1
    cell_fill_color = pygame.Color(cell_color)
    background_fill_color = pygame.Color(background_color)

    running = True
    while running:
        event = pygame.event.poll()
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_ESCAPE or event.key == pygame.K_q:
                running = False

        window.fill(background_fill_color)

        for row in range(grid.rows):
            for col in range(grid.cols):
                if grid[row, col]:
                    x = col * cell_width + border_size
                    y = row * cell_height + border_size
                    width = cell_width - border_size
                    height = cell_height - border_size

                    random_color = rainbow[random.random_si64(0, len(rainbow)-1)]
                    cell_fill_color = pygame.Color(random_color)

                    pygame.draw.rect(
                        window, cell_fill_color, (x, y, width, height)
                    )
        pygame.display.flip()
        time.sleep(pause)
        grid = grid.evolve()
    pygame.quit()

def main():
    start = Grid.random(128, 128)
    run_display(start)

