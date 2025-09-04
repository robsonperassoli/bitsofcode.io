# Phoenix is Great... but you can build elixir web apps without it.

*DISCLAIMER: I truly love phoenix and appreciate what the team has built over the years, many of the libraries used here only exist because phoenix exists, so... Thank you!*

## The Inspiration

Lately I've been meaning to publish some things, things I've learned, maybe tutorials, opinions and ideas. Writing is one of those basic skills that will never get outdated and I feel like it's time I do something about it and practice. My first thought was: ok, where do I publish that stuff? My website is just a box with my name and a couple of links, so I need something better. I could use a content generator like Jekyll or Tableau, maybe substack or medium, but then the brilliant idea presented itself... what if I build my own thing? Classic!

I've started my developer journey in the late 00s, during the web 2.0 boom and at the time things like Wordpress, Drupal and Joomla were hot. Since in those days I worked mostly with websites serving dynamic content, I took inspiration from these open source web apps and crafting mini frameworks to use on my work. This was probably the most fun I had my whole career, not particularly because I was building something great, but because I was learning a lot.

I want that feeling back, the feeling of rediscovering the wheel and not worrying about it. That's why I decided to just  pick some foundational libraries and DIY my way through it instead of going the sane route and just use phoenix out of the box.

## The Project

I expect something simple, basic blog layout and the possibility of writing using markdown format. For that I'll probably need to:

- Receive HTTP requests and send responses;
- Parsing markdown files into html;
- Serve static content like images and css.

With that in mind, I could quickly think of some well known libraries. For handling HTTP I can use [Plug](https://github.com/elixir-plug/plug) and [Bandit](https://github.com/mtrudel/bandit). [Earmark](https://github.com/pragdave/earmark) will be used for handling markdown and [EEx](https://hexdocs.pm/eex/EEx.html) as a basic templating engine, we'll also use [YamlElixir](https://github.com/KamilLelonek/yaml-elixir) for parsing the markdown front matter.

Let's get started, it's not that hard, I promise.

Plug is the barebones of our app, it is a specification for composing functions as a pipeline. It also offers some nice plug implementations like a basic router, a logger, session management, status file serving and so on, you can find more details in their [readme](https://github.com/elixir-plug/plug?tab=readme-ov-file#available-plugs). For this app I only need `Plug.Static`, `Plug.Router` and `Plug.Logger`.

The router will define how url's get served, I've created a router named [`Boc.Router`](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/router.ex) that uses the Router plug. The `Plug.Router` module gives us some helper functions to define http handlers like: get, post, put and delete and some other functions to send content back to the browser with the proper status code. The plug system always works with the [Plug.Conn](https://github.com/elixir-plug/plug/blob/main/lib/plug/conn.ex) struct, where one plug comes after the other always modifying the data in the `%Conn{}` struct, very neat! Pluggable you should say.

For this project I don't need too much from the router, just serve the home page at `GET /` and a specific article at `GET /:key` where key is the file name of the `.md` file. On top of that I'll need to serve some static content like css and images, Plug also gets me covered there with `Plug.Static`. It's simple to set it up, just adding ` plug(Plug.Static, at: "/public", from: :boc)` on top of the router module will serve files from the `priv/static` folder of the project, note that the `:boc` is the elixir application name. With that setup, `GET /public/styles.css` will serve `priv/static/styles.css`, love it!

Ok, so far we have basic http functionality without too much effort, we have to start thinking about adding some of the markdown serving I was talking about, because that is the real juice of the project. The Earmark developers make this SOOO EASY for us. Once you have it installed, parsing `.md` files in html is as easy as `Earmark.as_html!("# Hello World!")`.

My first idea was to compile all markdown files and serve them from disk, but I soon realized I didn't need to do that, for the amount of data I have it can be stored in memory for faster retrieval, so the articles will be compiled at startup and saved in memory. Once the app starts, I'll list all the files in the `priv/articles` folder, compile them and store in an elixir [`Agent`](https://hexdocs.pm/elixir/Agent.html) for retrieval. The agent ([`Boc.Articles.DB`](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/articles/db.ex)) starts under the application supervisor and compiles all the articles into a map so I can pull them using the `:key` from the url.

At this point the foundation is done, we have markdown files served with the respective file name on the url and it's functional. There is one detail I'm not covering here though, the [front matter](https://jekyllrb.com/docs/front-matter/). This is where you store markdown files metadata, like: title, publication date, tags and so on. You can check the implementation details for that [here](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/markdown.ex).

What we have is good, but for the app to be considered done for me I still needed some type of layout engine, technically I didn't need that, but I wanted to take it a bit further. For the layout engine I decided to use [EEx](https://hexdocs.pm/eex/EEx.html) which is a basic template engine that comes for free with elixir. Yes, that's the one with the `<%=` for dynamic content interpolation.

You can use EEx in a couple of ways, I've decided to use `EEx.function_from_file` utility, I can use this function to define a render function for a given template. I created the [`Boc.Layout`](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/layout.ex) module for that and asked [EEx](https://hexdocs.pm/eex/EEx.html) to create a function named `render` that expects the article as argument and renders the `priv/layout.html.eex` template. See the [router](https://github.com/robsonperassoli/bitsofcode.io/blob/main/lib/boc/router.ex#L35) to contemplate how clean and simple that process is.

Well, that's pretty much it. Just a bit more of html and css for the layout/markdown tags and I have my own static markdown website.

Check out the complete code [here](https://github.com/robsonperassoli/bitsofcode.io).

## The End

Creating this simple content app was a very satisfactory experience. The app itself is quite simple, but the process of picking the libraries, thinking about the code structure, where to store the data, how to route requests, all these simple decisions exercise parts of my brain that sometimes just go on auto-pilot when using Phoenix, since most of the conventions were picked for me.

Well, if you got this far I hope this article served of something and was not an utter waste of time and maybe inspired you to DIY as well, it's a fun and enjoyable process.
