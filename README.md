# neon-dreams-toolkit
A separate repository for the CLI and GUI tools used by my primary game dev project, Neon Dreams. This README goes over each tool in some detail. Tools are not in any real order, but all tools that are in this repo are listed in this document. The vast majority of these tools are written in [Ruby](), a weird, magical scripting language that came into existence in the early 2000s. The syntax is, I'll admit, quite unique, but it's a weird kind of beautiful, at least to me. So I chose Ruby over the other languages I know; `Python`, `C / C++`, etc.. I chose Ruby to both hopefully put Ruby in a niche outside being used in Web stuff, but also to learn the language.

<!-- FINISH DOCS ASAP -->
# item_editor.rb

The item editor is a simple CLI application in which items are created in the plain JSON schema that Neon Dreams recognizes:

```json
{
    "item_id": {
        "name": "",
        "desc": "",
        "texture": "",
        "attributes": []
    }
}
```

A very straightforward scheme. Attributes are hard to explain, they are better explained in the documents within the `/docs` directory in the official Neon Dreams repository. This scheme was drawn up, prioritizing my laziness above all else, even by hand, someone could bang out a JSON item in a few minutes. But due to the amount of items that exist, a tool to automate was needed, or at least speed up the processes in general. And that is where this script comes in. Of course, this is just the JSON creation. As seen in the `/assets` directory: items, NPCs, heck, even the quests are all packed into encrypted formats. Those are done in the `*_packager.rb` tools come into play.
