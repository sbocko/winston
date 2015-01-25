package winston

import grails.plugin.springsecurity.annotation.Secured
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured([Role.ROLE_USER])
class KnnResultController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond KnnResult.list(params), model:[knnResultInstanceCount: KnnResult.count()]
    }

    def show(KnnResult knnResultInstance) {
        respond knnResultInstance
    }

    def create() {
        respond new KnnResult(params)
    }

    @Transactional
    def save(KnnResult knnResultInstance) {
        if (knnResultInstance == null) {
            notFound()
            return
        }

        if (knnResultInstance.hasErrors()) {
            respond knnResultInstance.errors, view:'create'
            return
        }

        knnResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'knnResult.label', default: 'KnnResult'), knnResultInstance.id])
                redirect knnResultInstance
            }
            '*' { respond knnResultInstance, [status: CREATED] }
        }
    }

    def edit(KnnResult knnResultInstance) {
        respond knnResultInstance
    }

    @Transactional
    def update(KnnResult knnResultInstance) {
        if (knnResultInstance == null) {
            notFound()
            return
        }

        if (knnResultInstance.hasErrors()) {
            respond knnResultInstance.errors, view:'edit'
            return
        }

        knnResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'KnnResult.label', default: 'KnnResult'), knnResultInstance.id])
                redirect knnResultInstance
            }
            '*'{ respond knnResultInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(KnnResult knnResultInstance) {

        if (knnResultInstance == null) {
            notFound()
            return
        }

        knnResultInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'KnnResult.label', default: 'KnnResult'), knnResultInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'knnResult.label', default: 'KnnResult'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
