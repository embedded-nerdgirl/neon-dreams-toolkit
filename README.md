# neon-dreams-toolkit
A separate repository for the CLI and GUI tools used by my primary game dev project, Neon Dreams. This README goes over each tool in some detail. Tools are not in any real order, but all tools that are in this repo are listed in this document. The vast majority of these tools are written in [Ruby](https://www.ruby-lang.org/en/), a weird, magical scripting language that came into existence in the early 2000s. The syntax is, I'll admit, quite unique, but it's a weird kind of beautiful, at least to me. So I chose Ruby over the other languages I know; `Python`, `C / C++`, etc.. I chose Ruby to both hopefully put Ruby in a niche outside being used in Web stuff, but also to learn the language.

# item_editor.rb

The item editor is a simple CLI application in which items are created in the plain JSON schema that Neon Dreams recognizes:

```json
{
    "item_id": {
        "name": str,
        "desc": str,
        "texture": str,
        "attributes": []
    }
}
```

A very straightforward scheme. Attributes are hard to explain, they are better explained in the documents within the `/docs` directory in the official Neon Dreams repository. This scheme was drawn up, prioritizing my laziness above all else, even by hand, someone could bang out a JSON item in a few minutes. But due to the amount of items that exist, a tool to automate was needed, or at least speed up the processes in general. And that is where this script comes in. Of course, this is just the JSON creation. As seen in the `/assets` directory: items, NPCs, heck, even the quests are all packed into encrypted formats. Those are done in the `*_packager.rb` tools come into play.

# npc_editor.rb

Much like the prior `item_editor.rb`, this program is a CLI application, also creating JSON schema, but in a much more loose fashion for NPCs.

```json
{
    "npc_id": {
        "name": str,
        "type": str,
        "texture": str,
        "dialogue": []
    }
}
```

That's right, the JSON for an item and an NPC is identical, lazy and efficient. But unlike a stream of constants as seen in items, the `attribues` array is replaced with a large array of `dialogue` strings that the NPC could say at any given moment. there is no linear dialogue in most NPCs (some exceptions may apply as needed), so all dialogue can be chosen at random, leading to some interesting results in some NPCs.

# quest_editor.rb

This is a bit more complex than the last handful of programs. This editor has a bit more depth to it because quests are a bit more... amorphous in nature.

```json
{
    "quest_id": {
        "quest_name": str,
        "quest_id": str,
        "quest_provider": int,
        "quest_steps": [],
        "has_cutscene_pre": bool,
        "has_cutscene_post": bool,
        "rewards": []
    }
}
```

Quest steps are much like the infamous `attributes`, a large collection of constants buried in the C code, only documented in the primary repository. Since Quests are a lot more involved in creation and saving, a tool for this was all but required, and from this is where I got the idea to move all my tools into an external repository that I can update from outside Neon Dreams itself.

# item / npc / quest packager.rb

The packagers work in the same way, encrypting the raw JSON data into garbled binary via standard XOR encryption using a basic key. These scripts were obviously needed, but they generate more than an encryption file. The scripts produce the following:

 | extension | desc |
 |-----------|------|
 | .q        | Encrypted Quest File |
 | .npc      | Encrypted NPC File   |
 | .item     | Encrypted Item File  |
 | .sum      | SHA512 Checksum File |

 The checksum is just for development, to ensure things went fine. The keys are stored in the binary of Neon Dreams, so there is no worry about making vanilla files unusable without causing irreprable harm to the file. Modded files are another topic for another time.