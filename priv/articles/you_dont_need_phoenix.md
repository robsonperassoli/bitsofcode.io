# You don't need Phoenix... or I love phoenix but have some extra time on my hands.

*DISCLAIMER: I trully love phoenix and appreciate what the team has built over the years, many of the libraries used here only exist because phoenix exists, so... Thank you!*

A few years a go I've created a very basic graphql API for listing FIFA (the game) players, I don't even remember why I've done that, but basically I just started a new mix project with `--sup`, added ecto, plug and cowboy as dependencies and boom, it worked like a charm for my limited use case.

For me, these types of hack your own thing type of projects bring back a lot of great memories from when I was just starting web development and using `include 'header.php'` like a maniac and having lots of fun doing that. I'm not recommending you do this at work by any means, I wouldn't, but projects like these are the perfect place to go crazy and sharpen your skills.

I've been planning to write more and for that I need a place to publish my "work", so I've decided to combine both of these things in my mind and build a basic static site generator to publish what I write. Yes, I'm building it, with a few foundational elixir libraries like: [Bandit](https://github.com/mtrudel/bandit), [Plug](https://github.com/elixir-plug/plug), [Earmark](https://github.com/pragdave/earmark) and [YamlElixir](https://github.com/KamilLelonek/yaml-elixir). It's not that hard, I promise.

Let's start with the basics, we'll need to interpret HTTP requests and serve content, for that we'll use Plug, well... Bandit in fact. Bandit is the web framework, handles TCP and HTTP, but both libraries will work together to serve content. Initially plug was used along with cowboy, a web framework that was written and erlang and I think is quite popular with erlang folks. In recent years though Bandit has been gaining traction and becoming a popular alternative to cowboy in the elixir community, it's written in elixir and has some performance gains in comparison to cowboy.

I'm not going over all the details, just add plug and bandit to your mix file dependencies function. Plug offers some nice default plugs that you can use to handle your http requests, they include a basic router, a logger, session management, status file serving and so on, you can find more details in their [readme](https://github.com/elixir-plug/plug?tab=readme-ov-file#available-plugs). for this project We'll use the `Plug.Static`, `Plug.Router` and `Plug.Logger`.

To serve urls I've created a router named [`Boc.Router`](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/router.ex) that uses the plug Router. The `Plug.Router` module will give you some helper functions to define the http handlers like: get, post, put and delete functions for the HTTP methods as well as some other functions to send content back to the browser. The plug system always works manipulating the [Plug.Conn](https://github.com/elixir-plug/plug/blob/main/lib/plug/conn.ex) struct, working as a pipeling where one plug comes after the other always modifying the data in the `%Conn{}` struct, very neat!

For this particular project we don't need anything too specific, I need to serve a home page at `GET /` and serve a specific article at `GET /:key` where key is the file name of the md file on the file system. Quite simple to do that with the `Plug.Router`. Of course I'll need to serve some static content like css and images, Plug also gets me covered there with `Plug.Static`. It's so simple to set it up, just add ` plug(Plug.Static, at: "/public", from: :boc)` on top of your router module and it will start serving files from the `priv/static` folder of you project, note that the `:boc` is my application name. Now `GET /public/styles.css` will serve `priv/static.styles.css`, love it!

Ok, so far we have basic http functionality without too much effort, we have to start thinking about adding some of the markdown serving I was talking about, because that is the real juice of the project. The people at the Earmark make this SOOO EASY for us, of course first we have to add `:earmark` as a dependency. Of the dependency is added to the project transforming `.md` files in html is as easy as `Earmark.as_html!("# This is the level 1 title")`.

At first i though I should compile all markdown files and serve the from disk, but I soon realized I could just serve it from memory, it's easier to manage and I don't have that many articles anyways. For that I'll compile all files from the `priv/articles` folder when the app starts and keep them in an elixir [`Agent`](https://hexdocs.pm/elixir/Agent.html), a nice abstraction on top of OTP to save state. I've created an Agent module named [`Boc.Articles.DB`](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/articles/db.ex), it will start with the application supervisor and compile all the articles into a map so I can pull them using the `:key` from the url showed earlier.

The foundation is done, we have markdown files served with the respective file name on the url, it's functional at this point. There is one detail I'm not covering, which is the [front matter](https://jekyllrb.com/docs/front-matter/) of the markdown file. I'm using a yaml front matter here to store meta data about the markdown file, like title, publication date and so on. Implementation details can be found [here](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/markdown.ex).

For this app to be considered done for me I still needed some type of layout engine, technically I didn't need that, but I wanted to take it a bit further. For the layout engine I decided to use [EEx](https://hexdocs.pm/eex/EEx.html) which is basic template engine that comes for free with elixir. Yes, that's the one with the `<%=`.

You can use EEx in a couple of ways, I've decided to use `EEx.function_from_file` utility, once called in a module will defined a function in that same module that you can use to render the template passing the required values. I created the [`Boc.Layout`](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/layout.ex) module for that and EEx will put a function named `render` that expects the article as argument and will render the `priv/layout.html.eex` file. See the [router](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/router.ex#L35) to contemplate how simple rendering a template is.

You probably realized this is not a tutorial by any means, it's not intended to be, my point with this post is to share my experience and some opinions, maybe even inspire you a bit to build your own thing, learn and explore.

Creating this app makes me appreciate all the work put into phoenix even more. But on the other hand having only one big framework in the community feels kind of like monoculture, there are goods and bads to that, but ultimately i don't think is very healthy. We are lucky to have all these amazing libraries, many of them built to use with phoenix, most of them very easy to plug into in a plain regular elixir app, we should leverage that more.

I'll leave this [video](https://www.youtube.com/watch?v=BO-8Hx8kPtA) from Garret Smith that goes in a similar vein, it's erlang but it's easy to watch, I recommend.

If you want to use this app yourself or just want to check out the code, it's [here](https://github.com/robsonperassoli/bitsofcode.io).







