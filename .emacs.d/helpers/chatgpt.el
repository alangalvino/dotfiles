(require 'subr-x)

(use-package request
  :ensure t
  :custom
  (setq request-message-level -1))

;;; Printing helpers -------------------------------------------------------------------------------------------

(defconst +chatgpt-buffer-name+ "*ChatGPT*")

(defcustom chatgpt-api-key ""
  "OpenAPI API Key")

(cl-defun +chatgpt/message-string (text)
  (format "[ChatGPT]: %s" text))

(cl-defun +chatgpt/message (text)
  (message "[ChatGPT]: %s" text))

;; API request helpers -----------------------------------------------------------------------------------------

(cl-defun +chatgpt/parse-response-text (response)
  (let* ((choices (assoc-default 'choices response))
         (first-choice (aref choices 0))
         (first-choice-message (assoc-default 'message first-choice))
         (text (string-trim (assoc-default 'content first-choice-message))))
    text))

(cl-defmacro +chatgpt/with-success-response (body)
  `(cl-function (lambda (&key data &allow-other-keys)
                  (let ((response-text (+chatgpt/parse-response-text data)))
                    ,body))))

(cl-defun +chatgpt/api-call (&key prompt instruction callback)
  (let* ((prompt-text (if instruction (concat instruction " " prompt) prompt))
         (url "https://api.openai.com/v1/chat/completions")
         (headers `(("Content-Type" . "application/json")
                    ("Authorization" . ,(concat "Bearer " chatgpt-api-key))))
         (data (json-encode
                `(("messages" . [(("role" . "user") ("content" . ,prompt-text))])
                  ("temperature" . 0.5)
                  ("model" . "gpt-3.5-turbo")))))
    (message data)
    (+chatgpt/message "Running...")
    (request
      url
      :type "POST"
      :headers headers
      :data data
      :parser 'json-read
      :success callback
      :error (cl-function
              (lambda (&rest args &key error-thrown &allow-other-keys)
                (message (+chatgpt/message-string "API Call Error: %S") error-thrown))))))


;; Buffer, region and input helpers ----------------------------------------------------------------------------

(defun +chatgpt/kill-buffer-widown ()
  (delete-window (get-buffer-window (get-buffer-create +chatgpt-buffer-name+))))

(defun +chatgpt/write-in-temp-buffer (text)
  (with-output-to-temp-buffer +chatgpt-buffer-name+
    (princ text)))

(defun +chatgpt/get-region-text ()
  (if (use-region-p)
      (buffer-substring (region-beginning) (region-end))
    (+chatgpt/message "No region selected.")))

(defun +chatgpt/replace-region-text (new-text)
  (when (use-region-p)
    (if (yes-or-no-p (+chatgpt/message-string "Replace selected region with new text? "))
        (let ((start (region-beginning))
              (end (region-end)))
          (delete-region start end)
          (insert new-text))
      (+chatgpt/message "Region replacement canceled.")))
  (+chatgpt/kill-buffer-widown))

(defun +chatgpt/get-prompt-text ()
  (read-string (+chatgpt/message-string "Send a message: ")))

(defun +chatgpt/get-instruction-text ()
  (read-string (+chatgpt/message-string "Ask for somenthing: ")))

(cl-defmacro +chatgpt/run (&key (user-input-method 'region) (instruction nil) (replace-text nil))
  `(let* ((text ,(if (eq user-input-method 'region) '(+chatgpt/get-region-text) '(+chatgpt/get-prompt-text))))
     (+chatgpt/api-call :prompt text
                        :instruction ,instruction
                        :callback (+chatgpt/with-success-response
                                   (progn
                                     (+chatgpt/write-in-temp-buffer response-text)
                                     ,(if replace-text '(+chatgpt/replace-region-text response-text)))))))

;; Main commands -----------------------------------------------------------------------------------------------

(defun chatgpt ()
  (interactive)
  (+chatgpt/run :user-input-method 'input-text))

(defun chatgpt/on-region ()
  (interactive)
  (let ((instruction (+chatgpt/get-instruction-text)))
    (+chatgpt/run :instruction instruction)))

(defun chatgpt/translate-to-latin ()
  (interactive)
  (+chatgpt/run
   :instruction "Translate to latin"
   :replace-text t))
