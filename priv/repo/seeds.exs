# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Oldskool.Repo.insert!(%Oldskool.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Oldskool.Repo
alias Oldskool.User
alias Oldskool.Site
alias Oldskool.Post

hmans = Repo.insert! %User{name: "Hendrik Mans", email: "hendrik@mans.de"}
site = Repo.insert! %Site{owner_id: hmans.id, title: "hmans is blogging, yo", host: "hmans.io", description: "The blog of Hendrik Mans."}

Repo.insert! %Post{
  author_id: hmans.id,
  title: "Hello world",
  body: "Uh, _hi world_, **long time** no see?\n\nHere's another paragraph."}
