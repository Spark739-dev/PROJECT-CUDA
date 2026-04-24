# CUDA Makefile

NVCC = nvcc
TARGET = app
SRC = src/main.cu

all:
	$(NVCC) $(SRC) -o $(TARGET)

run:
	./$(TARGET)

clean:
	rm -f $(TARGET)
