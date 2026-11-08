{{toc}}

# Wiki formatting (CommonMark)

This text uses the formatting that Redmine's wiki supports, so that a theme can be checked against all of it.

## Text

**Bold**, *italic*, ***bold and italic***, ~~strikethrough~~, `inline code`, and a [link to redmine.org](https://www.redmine.org/). URLs become links: https://www.redmine.org/projects/redmine

A line with a footnote.[^1]

[^1]: The footnote text.

> A blockquote.
>
> > A nested blockquote.

> [!NOTE]
> A note.

> [!WARNING]
> A warning.

## Lists

* An item
  * A nested item
    * A deeper item
* Another item

1. First
2. Second
   1. Nested
3. Third

- [ ] A task to do
- [x] A finished task

## Table

| Tracker | Status | Assignee | Done |
| --- | :---: | --- | ---: |
| Bug | New | John Smith | 0% |
| Feature | In progress | Dave Lopper | 60% |
| Support | Closed | Redmine Admin | 100% |

## Code

```ruby
def hello(name)
  puts "Hello, #{name}"
end
```

```css
.wiki pre {
  background: #fafafa;
}
```

```
Plain text without a language.
```

## Links to Redmine objects

* Issues: #1, ##2 (with the subject), #1-1 (a note), and an escaped !#1
* Wiki pages: [[CookBook documentation]], [[Another_page|another page]], [[CookBook documentation#Text|a section]], [[A page that does not exist]]
* A wiki page of another project: [[onlinestore:Start page]]
* Versions: version#2, version:"1.0"
* Projects: project:ecookbook, project:onlinestore
* Documents, news and forums: document#1, news#1, forum#1, message#1
* Users: user#2, user:jsmith, @jsmith
* Attachments: attachment:picture.jpg

## Macros

{{issue(1)}}

{{issue(2, project=true)}}

{{collapse(Show more)
Text inside a collapsible block.
}}

{{child_pages(Another_page)}}

{{thumbnail(picture.jpg, size=200, title=A thumbnail)}}

## Images

![An inline image](picture.jpg)

## Headings

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6

---

Text after a horizontal rule.
