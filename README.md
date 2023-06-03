# Stimulus Debounce

Stimulus Debounce is a web application built with Ruby on Rails 7, Tailwind CSS, RSpec and StimulusJS. Its main feature is a Github interface to search profiles that utilizes the debounce functionality provided by StimulusJS.

## Installation

To install and run Stimulus Debounce, follow these steps:

1. Clone the repository:

```sh
git clone https://github.com/b2evandro/stimulus-debounce.git
```
2. Install the required gems:

```sh
bundle install
```

3. Start the Rails server:

```sh
rails s
```

Open your web browser and navigate to http://localhost:3000.

## Features

Stimulus Debounce provides the following features:

* Github interface to search profiles
* Debounce functionality provided by StimulusJS
* Responsive design with Tailwind CSS
* Comprehensive test suite using RSpec

## Usage

To use Stimulus Debounce, simply enter a search term into the search bar on the home page and press enter or click the search button. The search results will be displayed below the search bar. As you type, the debounce functionality provided by StimulusJS will delay the search request until a certain amount of time has passed without any additional keystrokes, improving the overall performance of the application.
## Testing

Stimulus Debounce has a comprehensive test suite built with RSpec. To run the tests, simply run the following command:

```sh
rspec
```

## License

Stimulus Debounce is released under the [MIT License](https://opensource.org/licenses/MIT).