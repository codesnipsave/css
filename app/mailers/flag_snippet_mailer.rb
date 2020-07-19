class FlagSnippetMailer < ApplicationMailer
    default to: 'test2@mailinator.com'
    def flag_snippet(user, snippet)
        @user  = user
        @snippet = snippet
        mail(subject: "#{@snippet.title} (#{@snippet.id}) Flagged")
    end
end
