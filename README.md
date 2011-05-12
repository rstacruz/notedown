# Notedown
#### Markup language designed for taking notes

Notedown is a markup language designed for outliner-style documents. It is 
optimized to be inputted fast (like when you're taking notes), yet still 
retain the ability to export the documents as nicely-formatted HTML.

### Usage

Install:

    $ gem install notedown

Pass filename(s) as arguments:

    $ notedown file.nd > file.html

Or pipe via STDIN:

    $ cat file.nd | notedown - > file.html

### Example

This is a perfectly-valid Notedown document:

    # Headings begin with a pound sign

      Paragraphs always end with a period.

      Anything else is a list item
      This is also a list item
        This is a sub-item, because of its indentation

      You may group items by putting empty lines on them

    ----

    Horizontal rules are done with 4 or more dashes.

    ----

    Lists with headings:
      If a list item ends with a colon (like above), it's a list item heading (bold)

This example translates to the following HTML:

```html
<h1>Headings begin with a pound sign</h1>
<p>Paragraphs always end with a period.</p>

<ul>
  <li>Anything else is a list item</li>
  <li>This is also a list item
    <ul>
      <li>This is a sub-item, because of its indentation</li>
    </ul>
  </li>
</ul>

<ul>
  <li>You may group items by putting empty lines on them</li>
</ul>

<hr />
<p>Horizontal rules are done with 4 or more dashes.</p>
<hr />

<ul>
  <li><strong>Lists with headings</strong>
    <li>If a list item ends with a colon (like above), it's a list item heading (bold)</li>
  </li>
</ul>
```
