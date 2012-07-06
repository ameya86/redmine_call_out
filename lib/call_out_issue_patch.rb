require_dependency 'issue'

module CallOutIssuePatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods) # obj.method

    base.class_eval do
      alias_method_chain :watcher_recipients, :call_out
    end
  end

  module InstanceMethods # obj.method
    # Cc/Bccに@付きで指定されたユーザを追加する
    def watcher_recipients_with_call_out
       cc = watcher_recipients_without_call_out

       # 履歴なし＝新規と判断し、チケットの説明を見る
       # 履歴あり＝更新と判断し、一番新しいjournalのコメントを見る
       comment = (self.journals.size == 0)? self.description : self.journals.last.notes

       # @xxxを取り出す
       users = []
       match = /@([a-z0-9_\-@\.]+)/.match(comment)
       while match
         # ログインからユーザを取得
         users += User.find(:all, :select => 'id, type, login, mail', :conditions => ["login in (?)", match.captures])
         match = /@([a-z0-9_\-@\.]+)/.match(match.post_match)
       end
       cc |= users.collect(&:mail).uniq

       return cc
    end
  end
end

Issue.send(:include, CallOutIssuePatch)
