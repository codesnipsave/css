# Preview all emails at http://localhost:3000/rails/mailers/flag_snippet_mailer
class FlagSnippetMailerPreview < ActionMailer::Preview
def preview_flag_snippet
    FlagSnippetMailer.flag_snippet(User.first, Snippet.first)
end
end
