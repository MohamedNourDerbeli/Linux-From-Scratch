PY_SCRIPT := app/install.py
EXECUTABLE_NAME := install

all: $(EXECUTABLE_NAME)

$(EXECUTABLE_NAME): $(PY_SCRIPT)
	pyinstaller $^ && mv dist/$(EXECUTABLE_NAME) .

clean:
	rm -f dist/* && rm -f $(EXECUTABLE_NAME)
